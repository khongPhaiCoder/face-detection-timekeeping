import express, { Request, Response } from 'express';
import History from '../models/history';
import board from '../index';
import { HistoryType } from '../types/enum.types';
import five from 'johnny-five';
import { sendNotification } from '../configs/firebase.config';
import User from '../models/user';
import detectFace from '../utils/face-detect';
import { countWorkingDays } from '../utils/helper';

class HistoryController {
  public static async checkin(req: Request, res: Response) {
    try {
      const buffers: any = [];
      req.on('data', (chunk) => {
        buffers.push(chunk);
      });

      let labels: any[] = [];
      req.on('end', async () => {
        const completeBuffer = Buffer.concat(buffers);
        console.log(completeBuffer);
        
        if (completeBuffer) {
          labels = await detectFace(completeBuffer);
          if (labels.length > 0) {
            const listUserDetect: any[] = [];
            for (let i = 0; i < labels.length; i++) {
              if (labels[i] != 'unknown') {
                const user = await User.findById(labels[i]).select(['name', 'email']);
                listUserDetect.push(user);
              }
            }

            labels.forEach(async (userId) => {
              if (userId != 'unknown') {
                const currentDate = new Date();
                const formattedDate = currentDate.toLocaleDateString('en-GB');
                const currentHour = currentDate.getHours();
                const currentMinute = currentDate.getMinutes();
                var type = 1;
                const time = `${currentHour}:${currentMinute < 10 ? '0' + currentMinute : currentMinute}`;
                const result = await History.findOne({ user: userId, date: formattedDate });
                if (result == null) {
                  const history = new History({
                    user: userId,
                    date: formattedDate,
                    hitories: {
                      time: time,
                      status: HistoryType.CHECKIN,
                    },
                  });
                  await history.save();
                } else {
                  result.hitories.push({
                    time: time,
                    status: result.hitories.length % 2 == 0 ? HistoryType.CHECKIN : HistoryType.CHECKOUT,
                  });
                  if (result.hitories.length % 2 == 0) type = 2;

                  var countMinute = 0;
                  var startHour = 0;
                  var startMinute = 0;
                  var endHour = 0;
                  var endMinute = 0;
                  result.hitories.forEach((e, index) => {
                    if (index % 2 == 1) {
                      endHour = parseInt(e.time.slice(0, 2));
                      endMinute = parseInt(e.time.slice(3));
                      countMinute += endHour * 60 + endMinute - (startHour * 60 + startMinute);
                      startHour = 0;
                      startMinute = 0;
                      endHour = 0;
                      endMinute = 0;
                    } else {
                      startHour = parseInt(e.time.slice(0, 2));
                      startMinute = parseInt(e.time.slice(3));
                    }
                  });
                  result.time = countMinute;
                  await result.save();
                }
                const user = await User.findById(userId);
                const servo = new five.Servo({
                  pin: 9,
                 startAt: 0,
                });
                servo.to(180);
                board.wait(1000, () => {
                  servo.to(0);
                });
                user.token.forEach((e) => {
                  var message = {
                    to: e,
                    notification: {
                      title: type == 1 ? 'Bạn đã điểm danh vào thành công' : 'Bạn đã xin ra thành công',
                      body: type == 1 ? 'Bạn đã điểm danh vào thành công' : 'Bạn đã xin ra thành công',
                    },

                    data: {
                      //you can send only notification or only data(or include both)
                      title: 'ok cdfsdsdfsd',
                      body: '{"name" : "okg ooggle ogrlrl","product_id" : "123","final_price" : "0.00035"}',
                    },
                  };
                  sendNotification(message);
                });
              }
            });
          }
        }

        res.status(200).send({
          message: 'Success',
        });
        res.end();
      });
    } catch (error) {
      res.status(400).send(error);
    }
  }

  public static async getListById(req: Request, res: Response) {
    try {
      const currentDate = new Date();
      const { month, year, id } = req.query;
      const formattedDate = currentDate.toLocaleDateString('en-GB');
      const user = await User.findById(id).select(['name', 'email', 'salaryBase']);
      const salaryBase = parseInt(user.salaryBase);
      var dateWorking;
      var query;
      if (month != null && year != null) {
        query = month + '/' + year;

        dateWorking = countWorkingDays(year, month);
      } else {
        query = formattedDate.slice(3);
        dateWorking = countWorkingDays(currentDate.getFullYear(), currentDate.getMonth() + 1);
      }

      const result = await History.find({ user: id, date: { $regex: query } });

      var numberOfAttendance = 0;
      var numberOfAbsent = 0;
      var numberOfUnknow = 0;
      var time = 0;
      result.forEach((e) => {
        if (e.absent == HistoryType.ABSENT) numberOfAbsent++;
        else if (e.absent == HistoryType.UNKNOW) numberOfUnknow++;
        else {
          time += parseInt(e.time);
          numberOfAttendance++;
        }
      });
      const totalSalary = Math.floor( (salaryBase *time) / ( dateWorking * 8 * 60)) ;

      res.status(200).send({
        data: result,
        numOfAbsent: numberOfAbsent,
        numOfUnknow: numberOfUnknow,
        numOfAttendance: numberOfAttendance,
        timetotal: time,
        totalSalary: totalSalary,
      });
    } catch (error) {
      res.status(400).send(error);
    }
  }
  public static async requestAbsent(req: Request, res: Response) {
    const { user, date } = req.body;
    const history = new History({
      user: user,
      date: date,
      absent: HistoryType.ABSENT,
    });
    await history.save();
    res.status(200).send({
      message: 'Success',
    });
  }
}

export default HistoryController;
