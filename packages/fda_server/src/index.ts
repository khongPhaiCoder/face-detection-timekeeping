import chalk from 'chalk';
import app from './app';
import five from 'johnny-five';

const board = new five.Board();

const server = app.listen(app.get('port'), () => {
  console.log(chalk.greenBright(`Listening on port ${app.get('port')} in ${app.get('env')} mode`));
});
export default board;
