function convertMinutesToHours(minutes) {
  var hours = Math.floor(minutes / 60); // Divide minutes by 60 to get the whole number of hours
  var remainingMinutes = minutes % 60; // Use modulo operator to get the remaining minutes

  return hours + " giờ " + remainingMinutes + " phút";
}
module.exports = {
  convertMinutesToHours: convertMinutesToHours,
};
