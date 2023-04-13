import udp from 'k6/x/udp';
import { check } from 'k6';


export default function () {
  const conn = udp.connect('localhost:33333');
  //udp.writeLn(conn, 'Say Hello');
  udp.writePkt(conn, 0x65);
  let res = String.fromCharCode(...udp.read(conn, 1024))
  check (res, {
    'verify ag tag': (res) => res.includes('d')
  });
  udp.close(conn);
}
