import express, { Request, Response } from 'express';
import FileController from '../controllers/fileController';

const router = express.Router();

router.post('/checkin', FileController.checkin);
router.post('/checkout', FileController.checkout);
router.get('/', FileController.getTest);

export default router;
