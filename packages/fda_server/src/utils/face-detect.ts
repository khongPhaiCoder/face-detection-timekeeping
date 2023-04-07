import faceapi from 'face-api.js';
import path from 'path';
import { __dirname } from '../config';
import User from '../models/user';
import { loadImage, Image, createCanvas } from 'canvas';
const MODAL_PATH = path.join(__dirname, 'modelsTraining');
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
export default detectFace;
