import udp from 'k6/x/udp';
import { check } from 'k6';


export default function () {
  const conn = udp.connect('localhost:14755');
  console.log("send 0x000076afed839da8")
  var seq = Math.floor(Math.random() * 1000) + 1;
  var err = udp.writePktEx(conn, 3, 0, seq, 0x000076afed839da8);
  let res = String.fromCharCode(...udp.readPkt(conn, seq, 1024))
  check (res, {
    'verify ag tag': (res) => res.includes('Success')
  });
  udp.close(conn);
}
