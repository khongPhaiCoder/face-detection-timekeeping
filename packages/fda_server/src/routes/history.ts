import express, { Request, Response } from 'express';
import HistoryController from '../controllers/historyController';

const router = express.Router();

router.post('/checkin', HistoryController.checkin);
router.get('/user', HistoryController.getListById);

export default router;
