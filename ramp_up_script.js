import udp from 'k6/x/udp';
import { check } from 'k6';



/* our list of queries heres*/
var queries = [
0x00001b056d,
0x00002b1ebc,
0x00002b23a6,
0xfffff88bdf
]

export const options = {
  scenarios: {
    stress: {
      executor: "ramping-arrival-rate",
      preAllocatedVUs: 400,
      timeUnit: "1s",
      stages: [
        { duration: "1m", target: 18000 }, 
        { duration: "1m", target: 25000 },
        { duration: "1m", target: 30000 },
        { duration: "1m", target: 35000 },
        { duration: "1m", target: 45000 },
        { duration: "1m", target: 50000 },
        { duration: "1m", target: 75000 },
        { duration: "1m", target: 100000 },
      ],
    },
  },
};
export default function () {

  const conn = udp.connect('localhost:14788');
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
