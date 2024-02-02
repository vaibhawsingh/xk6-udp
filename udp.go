package udp

import (
        "bytes"
        "encoding/binary"
        "net"
        "time"
        "go.k6.io/k6/js/modules"

)

func init() {
        modules.Register("k6/x/udp", new(UDP))
}

type UDP struct{}

type REQ struct {
        magic       uint16  /* set to s_magic */
        version     uint16
        flags       uint16 /* Flag giving more details about if active segment filtering is needed or not etc */
        n_ids       uint16
        req_timeout uint32
        request_id  [16]byte
        key         [17]byte
}

func (c *REQ) SetHeader(ver uint32, flag uint32, seq uint32) {
        c.version = 0x0001
        c.magic   = 0xABCD
        c.flags   = 0
        c.n_ids   = 1
        c.req_timeout =  0
}

func (udp *UDP) Connect(addr string) (net.Conn, error) {
        conn, err := net.Dial("udp", addr)
        if err != nil {
                return nil, err
        }

        return conn, nil
}

func (udp *UDP) WritePktEx(conn net.Conn, ver uint32, flag uint32, seq uint32, key [17]byte) error {

        var r REQ
        //r.SetHeader(ver, flag, seq)
        r.version = 0x0001
        r.magic   = 0xABCD
        r.flags   = 0
        r.n_ids   = 1
        r.req_timeout =  0
        r.key = key
        buf := &bytes.Buffer{}
        err := binary.Write(buf, binary.LittleEndian, r)

        _, err = conn.Write(buf.Bytes())
        //_, err := conn.Write([]byte(fmt.Sprintf("%d", r)))
        if err != nil {
                return err
        }

        return nil
}

func (udp *UDP) Write(conn net.Conn, data []byte) error {
        _, err := conn.Write(data)
        if err != nil {
                return err
        }

        return nil
}

func (udp *UDP) ReadPkt(conn net.Conn, seq int, size int) ([]byte, error) {
        buf := make([]byte, size)
        conn.SetReadDeadline(time.Now().Add(1 * time.Second))
        _, err := conn.Read(buf)
       if err != nil {
        return nil, err
       }

        var seq1 uint32
        seq1 = uint32(buf[3]) + (uint32(buf[2]) <<8) + (uint32(buf[1])<<16)
        if uint32(seq) == seq1 {
                return []byte("Success"), nil
        }
        return []byte("Fail"), nil
}


func (udp *UDP) ReadPktEx(conn net.Conn, seq int, size int) ([]byte) {
        buf := make([]byte, size)
        conn.SetReadDeadline(time.Now().Add(1 * time.Second))
        _, err := conn.Read(buf)
       if err != nil {
        return nil
       }

        var seq1 uint32
        seq1 = uint32(buf[3]) + (uint32(buf[2]) <<8) + (uint32(buf[1])<<16)
        if uint32(seq) == seq1 {
                return buf
        }
        return nil
}


func (udp *UDP) Read(conn net.Conn, size int) ([]byte, error) {
        buf := make([]byte, size)
        _, err := conn.Read(buf)
        if err != nil {
                return nil, err
        }
        return buf, nil
}


func (udp *UDP) WriteLn(conn net.Conn, data []byte) error {
        return udp.Write(conn, append(data, []byte("\n")...))
}

func (udp *UDP) Close(conn net.Conn) error {
        err := conn.Close()
        if err != nil {
                return err
        }
        return nil
}
