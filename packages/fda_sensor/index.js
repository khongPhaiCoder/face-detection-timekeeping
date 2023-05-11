const { default: axios } = require("axios");
const { SerialPort, ReadlineParser } = require("serialport");
const port = new SerialPort({ path: "COM3", baudRate: 9600 }); // Thay đổi "COM3" bằng tên cổng COM của board Arduino của bạn
const parser = port.pipe(new ReadlineParser({ delimiter: "\r\n" }));

parser.on("data", (data) => {
  console.log("Khoảng cách: " + data + " cm"); // In giá trị khoảng cách đo được
  if (data < 40) {
    axios
      .get("http://192.168.43.168/checkin")
      .then((response) => console.log("success"))
      .catch((error) => console.error("error"));
  }
});

port.write("start\n"); // Bắt đầu đo khoảng cách
