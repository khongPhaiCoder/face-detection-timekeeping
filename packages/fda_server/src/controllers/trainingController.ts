import { Request, Response } from 'express';
import { uploadFileMiddleware } from '../utils/saveImage';
import User from '../models/user';
import faceapi from 'face-api.js';
import path from 'path';
import { __dirname } from '../config';
import { loadImage, Image, createCanvas } from 'canvas';
const MODAL_PATH = path.join(__dirname, 'modelsTraining');
import fs from 'fs';
import { Blob } from 'node-fetch';

const addImageForUser = async (req: Request, res: Response) => {
  try {
    const { userId } = req.params;
    const user = await User.findById(userId);
    await uploadFileMiddleware(req, res);
    // const arr: string[] = []
    if (req?.files?.length) {
      //@ts-ignore
      for (let i = 0; i < req?.files?.length; i++) {
        //@ts-ignore
        user?.imageTraining.push(req?.files[i].filename);
      }
    }
    await user?.save();
    return res.status(200).json('Success');
  } catch (error: any) {
    return res.status(500).json(error.message || 'Lỗi máy chủ');
  }
};

const imageTraining = async (req: Request, res: Response) => {
  try {
    const { userId } = req.params;
    const user = await User.findById(userId);
    const descriptors: any[] = [];
    if (user) {
      for (let i = 0; i < user.imageTraining.length; i++) {
        // for (let i = 0; i < 1 ; i ++){
        // arr.push(path.join(__dirname, 'src/public/userImages/',user.imageTraining[i]))
        const img = await loadImage(path.join(__dirname, 'public/userTraining/', user.imageTraining[i]));

        //@ts-ignore
        const detection = await faceapi.detectSingleFace(img).withFaceLandmarks().withFaceDescriptor();

        if (detection?.descriptor) {
          descriptors.push(detection?.descriptor);
        }
      }
      await User.findByIdAndUpdate(userId, {
        faceDescriptors: descriptors,
      });
    } else {
      return res.status(200).json('Không tìm thấy user');
    }
    return res.status(200).json('Success');
  } catch (error: any) {
    return res.status(500).json(error.message || 'Lỗi máy chủ');
  }
};

const faceDetect = async (req: Request, res: Response) => {
  try {
    const buffers: any = [];
    req.on('data', (chunk) => {
      buffers.push(chunk);
    });

    let labels: any[] = [];
    req.on('end', async () => {
      const completeBuffer = Buffer.concat(buffers);

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
          return res.status(200).json({
            result: listUserDetect.length > 0 ? listUserDetect : 'Không có giá trị',
          });
        } else {
          return res.status(200).json('Không tìm được người phù hợp');
        }
      }
      res.end();
    });
  } catch (error: any) {
    return res.status(500).json(error.message || 'Lỗi máy chủ');
  }
};

const detectFace = async (imageData: Buffer) => {
  const image = new Image();
  image.src = imageData;
  const canvas = createCanvas(image.width, image.height);
  const context = canvas.getContext('2d');
  context.drawImage(image, 0, 0, image.width, image.height);

  const faceDetectionOptions = new faceapi.SsdMobilenetv1Options({ minConfidence: 0.5 });
  const detections = await faceapi
    // @ts-ignore
    .detectAllFaces(canvas, faceDetectionOptions)
    .withFaceLandmarks()
    .withFaceDescriptors();
  const trainingData = await User.find().select(['name', 'faceDescriptors']);
  const faceDescriptors: any[] = [];
  for (let i = 0; i < trainingData?.length; i++) {
    const arrFloat32: any[] = [];
    if (trainingData[i].faceDescriptors != null) {
      for (let j = 0; j < trainingData[i].faceDescriptors?.length; j++) {
        const arr: any = new Float32Array(Object.values(trainingData[i].faceDescriptors[j]));
        arrFloat32.push(arr);
      }
      // console.log(arrFloat32);
      faceDescriptors.push(new faceapi.LabeledFaceDescriptors(trainingData[i].id as string, arrFloat32));
    }
  }
  const labeledDescriptors = faceDescriptors;
  const maxDescriptorDistance = 0.5;
  const faceMatcher = new faceapi.FaceMatcher(labeledDescriptors, maxDescriptorDistance);

  const labeledResults = detections.map((detection) => {
    const bestMatch = faceMatcher.findBestMatch(detection.descriptor);
    return {
      detection,
      label: bestMatch.label,
      distance: bestMatch.distance,
    };
  });
  console.log(labeledResults);
  const results = labeledResults.map((result) => {
    return result.label;
    //   box: result.detection.box,
    //   label: result.label,
    //   distance: result.distance
  });
  return results;
  // return trainingData;
};

export { imageTraining, addImageForUser, faceDetect };
