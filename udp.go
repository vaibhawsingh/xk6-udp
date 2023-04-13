package udp

import (
	"net"
    "fmt"
	"math/rand"
	"go.k6.io/k6/js/modules"

)

func init() {
	modules.Register("k6/x/udp", new(UDP))
}

type UDP struct{}

type REQ struct {
	header uint32
	key    uint64
}

func (c *REQ) SetHeader(ver uint32, flag uint32, seq uint32) {
	c.header |= (ver & 0x0000000f)
	c.header |= (flag << 8 & 0x00000f0)
	c.header |= (seq << 16 & 0xffffff00)
}


func (udp *UDP) Connect(addr string) (net.Conn, error) {
	conn, err := net.Dial("udp", addr)
	if err != nil {
		return nil, err
	}

	return conn, nil
}

func (udp *UDP) WritePkt(conn net.Conn, key uint64) error {

	var r REQ
	r.SetHeader(3, 0, uint32(rand.Int()))
	r.key = key
	_, err := conn.Write([]byte(fmt.Sprintf("%v", r)))
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
