export default class Config {
  public static NAME: String = process.env.APD_API_NAME ?? 'Appeal Planning Decision API';

  public static get PORT() {
    const tmpPort = Number(process.env.APD_API_PORT);

    return Number.isNaN(tmpPort) ? 4000 : tmpPort;
  }
}
