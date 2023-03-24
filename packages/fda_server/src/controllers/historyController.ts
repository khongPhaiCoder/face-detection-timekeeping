import express, { Request, Response } from 'express';
import History from '../models/history';
import { HistoryType } from '../types/enum.types';

class HistoryController {
  public static async checkin(req: Request, res: Response) {
    try {
      const { date, time, user } = req.body;
      const history = new History({
        user: user,
        date: date,
        time: time,
        status: HistoryType.CHECKIN,
      });
      await history.save();
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
        if (e.status == HistoryType.ABSENT) numberOfAbsent++;
        else if (e.status == HistoryType.UNKNOW) numberOfUnknow++;
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
}
export default HistoryController;
