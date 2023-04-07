import express, { Request, Response } from 'express';

import file from './file';
import auth from './auth';
import history from './history';
import training from './training';

const router = express.Router();

router.use('/file', file);
router.use('/authentication', auth);
router.use('/history', history);
router.use('/training', training);

export default router;
