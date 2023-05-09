import udp from 'k6/x/udp';
import { check, fail } from 'k6';
import { SharedArray } from 'k6/data';
import papaparse from 'https://jslib.k6.io/papaparse/5.1.1/index.js';


const csvData = new SharedArray("another data name", function() {
    return papaparse.parse(open('./in.txt'), { header: false, skipEmptyLines: true}).data;
});

export const options = {
  scenarios: {
    constant_request_rate: {
      executor: 'constant-arrival-rate',
      rate: 50,
      timeUnit: '1s', // 1000 iterations per second, i.e. 1000 RPS
      duration: '30s',
      preAllocatedVUs: 300, // how large the initial pool of VUs would be
      maxVUs: 300, // if the preAllocatedVUs are not enough, we can initialize more
    },
  },
};

export default function () {

        const element = csvData[Math.floor(Math.random() * csvData.length)];
        validate(element)
}

function validate(queryStr) {

        var query = Number(queryStr)
        //console.log(query);

  const conn1 = udp.connect('localhost:14755');
  const conn2 = udp.connect('localhost:14755');
  var seq = Math.floor(Math.random() * 1000) + 1;
  //console.log (query)
  var err = udp.writePktEx(conn1, 3, 0, seq, query);
  var err = udp.writePktEx(conn2, 3, 0, seq, query);
  let res1 = udp.readPktEx(conn1, seq, 1024)
  let res2 = udp.readPktEx(conn2, seq, 1024)
        //console.log (res1)
        //console.log (res2)


  if( !check (res2, {
    'verify same response': (res2) => JSON.stringify(res1) === JSON.stringify(res2),
  }))
        {
                console.log(queryStr);
                console.log(res1);
                console.log(res2);
         }

  udp.close(conn1);
  udp.close(conn2);
}
