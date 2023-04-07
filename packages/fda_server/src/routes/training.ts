import express, { Request, Response } from 'express';
import multer from 'multer';
import * as trainingController from '../controllers/trainingController';
const storage = multer.memoryStorage();
const upload = multer({ storage });
const router = express.Router();
router.post('/add-image-user/:userId', trainingController.addImageForUser);

router.post('/training-user/:userId', trainingController.imageTraining);
router.post('/detect', trainingController.faceDetect);

export default router;
