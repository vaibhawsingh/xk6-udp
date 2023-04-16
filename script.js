import udp from 'k6/x/udp';
import { check } from 'k6';



/* our list of queries heres
 */
var queries = [
0x000076afed,
0x00012e9773,
0x00018dc646,
0x0001c1efe6,
0x00020c61c8
]

export default function () {

  const conn = udp.connect('localhost:14755');
  var seq = Math.floor(Math.random() * 1000) + 1;
  var query = queries[Math.floor(Math.random()*queries.length)]
  //console.log (query)
  var err = udp.writePktEx(conn, 3, 0, seq, query);
  let res = String.fromCharCode(...udp.readPkt(conn, seq, 1024))
  check (res, {
    'verify ag tag': (res) => res.includes('Success')
  });
  udp.close(conn);
}
