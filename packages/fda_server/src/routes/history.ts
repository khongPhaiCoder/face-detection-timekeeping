import express, { Request, Response } from 'express';
import HistoryController from '../controllers/historyController';
import * as trainingController from '../controllers/trainingController';

const router = express.Router();

router.post('/checkin', HistoryController.checkin);
router.get('/user', HistoryController.getListById);
router.get('/absent', HistoryController.requestAbsent);

export default router;
