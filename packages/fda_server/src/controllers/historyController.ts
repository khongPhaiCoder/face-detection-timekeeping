import express, { Request, Response } from 'express';
import History from '../models/history';
import board from '../index';
import { HistoryType } from '../types/enum.types';
import five from 'johnny-five';

class HistoryController {
  public static async checkin(req: Request, res: Response) {
    try {
      // const servo = new five.Servo({
      //   pin: 9,
      //   startAt: 0,
      // });
      // servo.to(180);
      // board.wait(1000, () => {
      //   servo.to(0);
      // });
      const { user } = req.body;

      const currentDate = new Date();
      const formattedDate = currentDate.toLocaleDateString('en-GB');
      const currentHour = currentDate.getHours();
      const currentMinute = currentDate.getMinutes();
      const time = `${currentHour}:${currentMinute < 10 ? '0' + currentMinute : currentMinute}`;
      const result = await History.findOne({ user: user, date: formattedDate });
      if (result == null) {
        const history = new History({
          user: user,
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
      res.status(200).send({
        message: 'Success',
      });
    } catch (error) {
      res.status(400).send(error);
    }
  }

  public static async getListById(req: Request, res: Response) {
    try {
      const result = await History.find({ user: req.query.id });
      var numberOfAttendance = 0;
      var numberOfAbsent = 0;
      var numberOfUnknow = 0;

      result.forEach((e) => {
        if (e.absent == HistoryType.ABSENT) numberOfAbsent++;
        else if (e.absent == HistoryType.UNKNOW) numberOfUnknow++;
        else numberOfAttendance++;
      });
      res.status(200).send({
        hitories: result,
        numberOfAbsent: numberOfAbsent,
        numberOfUnknow: numberOfUnknow,
        numberOfAttendance: numberOfAttendance,
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
