import udp from 'k6/x/udp';
import { check } from 'k6';


export const options = {
  scenarios: {
    constant_request_rate: {
      executor: 'constant-arrival-rate',
      rate: 75000,
      timeUnit: '1s', // 100000 iterations per second, i.e. 100K RPS
      duration: '2m',
      preAllocatedVUs: 1, // how large the initial pool of VUs would be
      maxVUs: 250, // if the preAllocatedVUs are not enough, we can initialize more
    },
  },
};

/* our list of queries heres
 */
var q = [
g:538a0fe8-996e-47a9-8a44-78dc2129b288,
g:e5430a18-218e-4fc4-b004-3514f02f0657,
g:0550624a-2787-448e-a51e-7deb0da4faa9,
g:dfbf5eae-e320-4519-a502-fcebe3e6638d,
g:323adc95-2278-48c6-a449-2a80ec5dd6c7,
g:d728593a-97a7-a0d3-78fd-74d147fe9da6,
g:eb19d02d-25a4-4894-bc9d-d3ff877e38d9,
g:924b63de-69a0-4223-85eb-93e95be065f4,
g:3334101b-6177-477d-a2fd-0e7419eca559,
g:47a48977-e9ad-4145-9761-00f3eda42e43,
g:24f272e1-a8fd-e438-d75f-d4ad91282b6b,
g:7c1c4a12-2853-4192-b33f-45276dcf2c03,
g:274865dd-1870-c395-64af-69d41da9c21b,
g:d1fd9a82-bb5e-4bd9-b00e-cd5570ab11cd,
g:d060bedd-53cc-45af-95f7-e28945f4bf36,
g:14d4b7ce-9683-4268-94be-3df55d538577,
g:8fd3dd2a-ac55-431c-ae6c-526678b34427,
g:36e27d24-2168-4d80-8be7-505bc7426840,
g:020cda82-3a48-401c-b949-61a250724ed2,
g:b55069d4-2cf3-4163-9951-94570d09e666,
g:f17cca29-8042-42e7-ba5d-2518b5dd087a,
g:f8943dfe-20ed-4786-86a8-39e3d0bc1146,
g:83b126ab-5877-4c40-b4fc-c7ea9a19b7c1,
g:b62821a0-90c9-4cb2-b81f-dfcb1746977b,
g:aab79e67-1681-a66a-29e4-dc09630611c8,
g:2902dee3-a6ba-42d8-9d67-41707620753c,
g:5a9529e4-29e4-374a-df68-088cb3d3d5a9,
g:801d6b53-70d5-41e1-9963-636e96f9ae90,
g:b298cb18-d6d2-4829-ba23-d7e671085b1e,
g:5b8e4389-f97b-4eb8-b4a4-5d4e1dff659c,
g:236115a5-a3f3-4412-aa12-345c939aa618,
g:066006d6-ec53-2aa6-9bdc-df90bd13fcad,
g:9cb44198-8e3f-4357-99c3-d316bcf2fc0c,
g:b0d04a2c-54a9-43cb-ac6e-23c42ceb5c1d,
g:23ed9b80-a07e-40cb-983f-29445ce5d8af,
g:801b7b92-42c4-4de6-9b7a-8171221a60f0,
g:b9f46ebc-555d-4618-a7c1-7efeac77ceae,
g:b96861c4-7a29-4e91-82d8-07ba576d4c68,
g:c4893a2c-772c-4532-82b0-9dc60ae4649f,
g:c4ee529b-4595-4dc1-8ada-ad9f0e27ec62,
g:52fe969f-7dbb-4082-abd2-9b8e4480bf67,
g:2d84f009-0929-446a-aa78-e386561ed48b,
g:cec19869-36c2-4972-8543-ee612e0a6e6b,
g:727e474e-154d-49f9-b76e-d2b383da4610,
g:57686077-5ad0-46a2-81d6-20e2a05185b6,
g:cd95f8cb-5019-8709-9df9-d704a30ccb17,
g:7f0492a6-1cd5-849b-6cb0-020d1587e5dd,
g:687f1dcc-760b-4542-8a01-9f9049b79009,
g:e9d86936-fad9-4727-9c73-27b5c8e8ac48,
g:7744fbd8-33a3-4991-9e6e-fdfc88b96457,
g:0571a8d7-5ecc-45b6-862a-0cc50d3ee125,
g:9ed5d4a5-9202-48c4-b699-fbfa448580fa,
g:1d554f89-6563-44df-af69-c5a8c0dc1860,
g:fcdbc10d-5c31-473e-bdd3-0731e2492999,
g:9fe025a0-af6e-4d6d-90fa-dc41d094b3cd,
g:03d87716-2e8f-4fb6-94fc-ea522f911e59,
g:d519234c-5e77-492b-92eb-030680e6a8ac,
g:9575fb5b-4295-4ee2-bf7c-f26232770e2b,
g:31325ebb-df56-4217-be2f-35d36f0ab1fa,
g:40400f68-b702-499b-a198-f286a18152ea,
g:affeb094-cbbc-4bd9-8a0e-0d2fee9534b1,
g:46588e7b-1af7-4386-9219-0df2d5db0289,
g:4b459522-805e-49ea-89c8-8cf76d6baad4,
g:ef886b50-d4e1-45a1-a24c-99613ebd7138,
g:09b5c8c5-239e-4dc2-9019-8880dcc75691,
g:503a3514-3fac-478b-b594-d65ae272ef3f,
g:b6e346c8-20dd-600e-bb36-137a32ee75f2,
g:87add81b-60fd-49b9-9dd8-6b884953eb56,
g:cc428c5a-d595-41a2-a3d9-62770ba63bd6,
g:8a142b95-341e-4da2-b088-2d676c25e62e,
g:c3cf4dd8-15d7-44da-8963-d4a7bb2beedf,
g:38610740-24fe-4427-a4a0-fac87e643ba4,
g:d9690850-9f96-42a4-9910-cd4c5495ed3d,
g:69a028a0-ee51-4d0d-a94b-04d12dc96c27,
g:6f49f148-6169-4108-8292-94a76483d2d4,
g:081d8661-1834-4602-9664-b062670f9779,
g:739fde4c-ad47-1ce6-831e-08a8bb61a890,
g:e7455c2d-8e47-4bef-9564-9c52e90f099a,
g:e33ef165-7d01-4f31-a7a3-104af9aac6a6,
g:f2fee015-7b0e-46c9-8af7-31d56c87f738,
g:8abe34ac-b66f-44ec-b485-547282ecd9aa,
g:db0329fd-95f9-441d-b643-5e639fd91889,
g:dba9fe80-2e23-463a-abea-b87526a9a15a,
g:5742e0e5-1244-4d71-8749-ab7e5709c950,
g:92addb9e-9f1c-4ee2-aedf-35fce9d72cab,
g:72580380-3633-428b-bfe3-627a8ea2c26a,
g:b3155012-c83f-4cac-b475-9504417a2573,
g:d4f90eea-7f2b-490a-b86d-b947e86ff83e,
g:a3609015-4151-f04b-e591-17fe0bd1073f,
g:6728f41b-8221-406a-86d8-99d28d81211f,
g:d11222c8-60aa-408d-bf4a-6f636a84a349,
g:9fc22275-0beb-6020-827c-c3e7aa5cb754,
g:988e9cc6-2958-4c4a-9e52-d7a9fba68e2c,
g:1d845132-10f7-4f1e-8947-32614cc1d4ef,
g:147b079c-fb7e-419d-a238-9580e6fbf671,
g:ff4baad8-f60b-4a60-87d8-326f786e98e7,
g:a5e11bef-d497-41f8-a952-8c87626cc7f0,
g:e125a54b-a7c5-4e17-a50c-81d9572a8191,
g:fe317163-ae12-4320-8da4-ee7bdca2c9fb,
g:dbe30c46-5cff-41be-9ebf-45f424c414ba,
g:421cf81b-6bac-46b7-a2b3-fe5a60f31033,
g:04dd14d3-013c-42ea-a566-ea31945ef872,
g:bf24ff87-a78b-4195-9be6-24226da88008,
g:44c603dd-b92e-43a0-9026-a96738ad33a1,
g:57bf8720-d2d2-40cf-9f9f-ef5c057331b2,
g:b2e7e179-3128-446f-852c-f9a6b4d90e7a,
g:fa289f6b-5db1-4b62-af31-d0a12326f14a,
g:259368af-42c0-46c5-af4f-58d48346c966,
g:1d3667a2-9d8e-4b30-b710-683dd688efce,
g:16350769-e442-43f0-a536-af46b0a01051,
g:9bad0cc7-6226-4a32-b849-9539ee8887c5,
g:02b75d27-04ad-4829-a24c-efa9fbbd40c4,
g:31a428df-1bc2-4e03-98de-7f9bf94ecdae,
g:efe33aa8-ffb9-44f8-b595-ce990fd7169f,
g:3acd816a-3caa-eac1-da00-1456a9e98345,
g:61669d5f-3e5a-40fd-9ee8-823fa59d7df7,
g:8559c7ae-59fc-4990-9995-857c43c55bd1,
g:7f06b688-1a93-47bf-ad64-570eabab2b7a,
g:f6d1fcd6-89f7-4880-9af3-3936cb6bb77b,
g:1a4a58bf-f1a6-4bed-b539-443b9b36037c,
g:b0b106c6-371f-430c-8ddf-e9a4c61f843c,
g:c9e5f4f3-77ad-4eab-9ad5-0950e89574ce,
g:5337f14d-c4c1-8adb-da99-487bbd8f4ed0,
g:dce30cfc-d1dc-45a8-85ed-00ab2d569df5,
g:fa3beefe-a59e-4d99-9cad-dba937b507f5,
g:cdbe074b-22f5-4358-9b05-00e842bdaafa,
g:65d5ea5f-0448-445e-8cc2-da7ffaa53f9d,
g:dc8c31c5-de30-4252-b981-ce8936ef0772,
g:1daa295b-02fb-42ea-b3bb-fdc1f13f35e3,
g:bb07a7d4-913b-4b72-8286-60cef181765e,
g:caced413-644f-4830-bd77-0f4c2fada247,
g:4c8018b9-5669-40bb-a8a5-0cf114a663d9,
g:0f0eb83c-7ac9-4b9a-a095-bd981088b7f0,
g:d4555e72-8325-43c4-8c2f-5b0484c3b8b5,
g:dbcb107e-f060-6bca-e3d3-37aed57026c4,
g:339f8d5e-1b03-43da-a209-dc6ee4975710,
g:e1220efe-bca8-49cc-b5b7-9f42f2ffaac9,
g:a68b8ada-9db5-45e2-a6d9-92cad46cbaf7,
g:289ae68f-5cdc-46d9-a948-6ec5c2917679,
g:6d546344-d3f9-48ad-b40d-5312b4502eaa,
g:6dbe2be2-701e-4354-ad0b-6d60f0e3778d,
g:330c00fc-ffdf-4d07-a332-912f158f068d,
g:b88bf616-5312-42dd-a8f6-4b907565eb69,
g:ba6d5b78-188c-4fa7-a811-cff7e28d3b26,
g:1f4fb203-efad-428f-bad2-41e7ee9ee91e,
g:cdd0b323-99e2-4058-a3a8-c3d552893868,
g:d0bd1511-d6c7-4a09-aa05-bca021f4dc1a,
g:d4c172de-b6a8-412a-b6b6-42c425eaf9e1,
g:5ae5e2c6-3905-44a2-8c6b-200ef8dcbcf3,
g:d2320c67-a277-d0e0-1569-3bb4a1995a2d,
g:c7f8c7e4-6e84-402d-b0cd-b790c975cc49,
g:477515a0-3845-43c6-9dfb-0750719fe3b7,
g:64363546-a2c1-4005-a48a-b63e92be72a9,
g:8fa2da6d-2845-4646-aead-4db3321a5ccc,
g:f3f3418a-840f-4d90-979c-b22a0cefa64c,
g:f1b7cc93-16c4-4799-b1aa-9062ec7ea86b,
g:eba3f3d8-87aa-c238-614c-59ce45ebc26b,
g:d8c87c7b-fc1c-41bd-a98a-2bf466b99d89,
g:68c732c3-ccd3-481c-93cf-d1cb8127f20b,
g:dce06926-c085-464d-8f6d-f9009bee2684,
g:b00a4979-c353-43bb-a241-1fe50bdbfadb,
g:f8df2421-7119-43ea-bee0-4be468b7afb4,
g:9f50b5e0-e492-3cee-93ea-254e7e72e933,
g:92857a26-66a6-449b-fa73-f728c4756dff,
g:e07f5768-3e73-4c7a-aac5-96d6dcb4210c,
g:94ffe184-2790-464c-9115-c3fe26abe1a5,
g:91c6a774-9b54-4e20-b7e0-9b32e2205535,
g:f7a273c6-cf56-b4d9-17a4-c5a1a805a655,
g:ead5c523-f68a-49f4-b2c6-2bb4c594a359,
g:7f59a595-96b8-469a-bc4f-ae1b6afa53d1,
g:378042fe-544e-4497-baaa-dd726e0d3016,
g:5898074d-6b99-4781-80fb-b65cb1eb3736,
g:ddda4133-026e-36a8-9801-eae5f74c6a03,
g:15051072-d90c-46eb-a115-83e21be853d6,
g:97ccbb20-d5c6-4fef-a5fe-16f04da6c3ac,
g:31db5ca0-bdbc-411c-b132-4008789d89bf,
g:4c9c9f09-07c8-4ae6-8de1-1afe81f6b1b8,
g:e5258216-1853-4fef-be75-4e5817df2156,
g:ba3e22b3-03b2-421a-9eea-79187984a0c9,
g:7b09e7e8-e7e8-1751-483d-db272ecdd707,
g:3c90137a-e946-4453-81ac-1a9b224f0744,
g:82a92662-23c6-4195-aaae-61809eb6ddce,
g:06b35e3b-8a73-4af6-8b0a-238165d063d7,
g:18e83ae9-0935-4c73-8421-610157f49fb2,
g:37ff892a-1602-4386-a0c7-68ea03fddf19,
g:f88decb7-c803-4ac1-9d92-e2288df64f22,
g:a748c779-f069-48e0-ace1-5ce833ff5044,
g:b4969e39-3d0d-47ed-a2c8-dd9cbc3ddb32,
g:021cc9ba-c9ba-fabd-1692-5fef04809618,
g:da8e67e9-652b-401a-a82d-3951d6b87740,
g:78180432-faa4-4d01-9417-94c7e11de7eb,
g:ee98875a-502a-46c7-8dc5-87ff507b34bd,
g:f6fd712e-b36e-468e-ab85-540bcc32e031,
g:ba82f79c-453e-43e4-88ec-228009484f8a,
g:4895079c-7c4c-43e6-840c-b4d61197e142,
g:6d4144f1-520b-49fa-984c-1ea6b693aa3f,
g:3beb1ed6-6e21-a8bc-6541-4affcee56a5c,
g:769eebe8-83fe-45aa-a6fd-a2f25f4d3c10,
g:8ee9dc69-d1cd-4bf6-b71e-20c8e4e7ae86,
g:99bfaf09-67d1-4069-383a-532dad85f890,
g:cf9f1040-7342-ecb4-75df-1f51a5937b76,
g:9d3596c4-652c-4e30-b86f-6daf34f22aad,
g:78a3451b-3be6-4695-bcf1-375e23bf33a7,
g:352d7064-4252-4e9b-8a3f-1b456020225a
]

const type = new Array(26);//use this array for identifier
type['4'] = 52
type['6'] = 54
type['a'] = 97
type['c'] = 99
type['g'] = 103
type['s'] = 115
type['p'] = 112
type['l'] = 108
type['h'] = 101
type['t'] = 116
type['f'] = 102
type['r'] = 114


export default function () {

  const conn = udp.connect('127.0.0.1:14755');
  var seq = Math.floor(Math.random() * 1000) + 1;
  let m = q.length // rows
  let n = 17 // columns
  let queries = Array(m).fill().map(entry => Array(n))
  for (var i = 0; i < q.length; i++)
  {
      var x = q[i]
      var k =0
      queries[i][k++] = type[x[0]]
    
      for(var j = 2;j<x.length;j++)
      {
          if(x[j]  == '-')
          {}
          else {
              var p = x[j]
              p += x[j+1]   
              j++
              queries[i][k++] = parseInt(p, 16)
          }
      }
      //console.log(queries[i])
  }
  
  var query = queries[Math.floor(Math.random()*queries.length)]
  //console.log (query)
    var err = udp.writePktEx(conn, 3, 0, seq, query);
      let res = String.fromCharCode(...udp.readPkt(conn, seq, 1024))
        check (res, {
            'verify ag tag': (res) => res.includes('Success')
              });
                udp.close(conn);
}
