import { Request, Response } from 'express';
import fs from 'fs';
class FileController {
  public static checkin(req: Request, res: Response) {
    // do something
    const buffers: any = [];
    req.on('data', (chunk) => {
      buffers.push(chunk);
    });
    req.on('end', () => {
      const fileToWrite = `src/public/images/captured-${Date.now()}.jpg`;
      const completeBuffer = Buffer.concat(buffers);
      fs.writeFileSync(fileToWrite, completeBuffer);
      if (fs.existsSync(fileToWrite)) {
        console.log('Save File Checkin success');
      } else {
        console.log('Save File failed');
      }
      res.end();
    });
    res.send('Hello World!');
  }
  public static checkout(req: Request, res: Response) {
    // do something
    const buffers: any = [];
    req.on('data', (chunk) => {
      buffers.push(chunk);
    });
    req.on('end', () => {
      const fileToWrite = `src/public/images/captured-${Date.now()}.jpg`;
      const completeBuffer = Buffer.concat(buffers);
      fs.writeFileSync(fileToWrite, completeBuffer);
      if (fs.existsSync(fileToWrite)) {
        console.log('Save File Checkout success');
      } else {
        console.log('Save File failed');
      }
      res.end();
    });
    res.send('Hello World!');
  }
  public static getTest(req: Request, res: Response) {
    res.send('Hello World!');
  }
}
export default FileController;
