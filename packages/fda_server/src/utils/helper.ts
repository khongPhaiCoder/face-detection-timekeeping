export function countWorkingDays(year, month) {
    let count = 0;
    const startDate = new Date(year, month - 1, 1);
    const endDate = new Date(year, month, 0);
  
    for (let date = startDate; date <= endDate; date.setDate(date.getDate() + 1)) {
      if (date.getDay() !== 0 && date.getDay() !== 6) {
        count++;
      }
    }
    
    return count;
  }