// print.ts
import hilog from "@ohos.hilog";

enum LogLevel {
  DEBUG = hilog.LogLevel.DEBUG,
  INFO = hilog.LogLevel.INFO,
  WARN = hilog.LogLevel.WARN,
  ERROR = hilog.LogLevel.ERROR,
}

class Logger {
  private static instance: Logger;
  private tag: string = "Print";

  private constructor(tag: string = "Print") {
    this.tag = tag;
  }

  public static getInstance(tag: string = "Print"): Logger {
    if (!Logger.instance) {
      Logger.instance = new Logger(tag);
    }
    return Logger.instance;
  }

  private log(level: LogLevel, message: any): void {
    if (typeof message === "object" && message !== null) {
      message = JSON.stringify(message, null, 2);
    }
    const timestamp = new Date().toISOString();
    const logMessage = `[${timestamp}] [${level}]: ${message}`;
    const wrappedMessage = this.addBorder(logMessage);

    switch (level) {
      case LogLevel.DEBUG:
        hilog.debug(0x0000, this.tag, wrappedMessage);
        break;
      case LogLevel.INFO:
        hilog.info(0x0000, this.tag, wrappedMessage);
        break;
      case LogLevel.WARN:
        hilog.warn(0x0000, this.tag, wrappedMessage);
        break;
      case LogLevel.ERROR:
        hilog.error(0x0000, this.tag, wrappedMessage);
        break;
    }
  }

  private addBorder(message: string): string {
    const lines = message.split('\n');
    const maxLength = Math.max(...lines.map(line => line.length));
    const topBottomBorder = `┌${'─'.repeat(maxLength + 2)}┐`;
    const sideBorder = `│ `;
    const bottomBorder = `└${'─'.repeat(maxLength + 2)}┘`;

    const borderedMessage = lines.map(line => `${sideBorder}${line}${' '.repeat(maxLength - line.length)} │`).join('\n');
    return `${topBottomBorder}\n${borderedMessage}\n${bottomBorder}`;
  }

  public debug(message: any): void {
    this.log(LogLevel.DEBUG, message);
  }

  public info(message: any): void {
    this.log(LogLevel.INFO, message);
  }

  public warn(message: any): void {
    this.log(LogLevel.WARN, message);
  }

  public error(message: any): void {
    this.log(LogLevel.ERROR, message);
  }
}

// 使用示例
const logger = Logger.getInstance();
export default logger;