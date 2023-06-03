using System;
using System.Linq;

public static class TelemetryBuffer
{
    const int PAYLOAD_LENGTH = 8;
    const int BASE_PREFIX = 0x100;

    public static byte[] ToBuffer(long reading)
    {
        return BuildBuffer(reading);
    }

    private static byte[] BuildBuffer(long reading) {
        byte[] payload = BitConverter.GetBytes(reading);
        byte prefix = 0;
        
        if (IsBetween(reading, Int16.MaxValue, 0)) {
            prefix = (byte)(sizeof(short));
        } else if (IsBetween(reading, -1, Int16.MinValue)) {
            prefix = (byte)(BASE_PREFIX - sizeof(short));
            payload = BitConverter.GetBytes((short)reading);
        } else if (IsBetween(reading, UInt16.MaxValue, UInt16.MinValue)) {
            prefix = sizeof(short);
        } else if (IsBetween(reading, Int32.MaxValue, 0)) {
            prefix = (byte)(BASE_PREFIX - sizeof(int));
            payload = BitConverter.GetBytes((int)reading);
        } else if (IsBetween(reading, -1, Int32.MinValue)) {
            prefix = (byte)(BASE_PREFIX - sizeof(int));
            payload = BitConverter.GetBytes((int)reading);
        } else if (IsBetween(reading, UInt32.MaxValue, UInt32.MinValue)) {
            prefix = sizeof(int);
        } else if (IsBetween(reading, Int64.MaxValue, Int64.MinValue)) {
            prefix = (byte)(BASE_PREFIX - sizeof(long));
        } 

        return PopulateBuffer(prefix, RightZeroPadBuffer(payload));

    }

    private static byte[] PopulateBuffer(byte prefix, byte[] payload) 
    {
        byte[] buffer = new byte[PAYLOAD_LENGTH + 1];
        buffer[0] = prefix;
        Array.Copy(payload, 0, buffer, 1, payload.Length);

        return buffer;
    }

    private static byte[] RightZeroPadBuffer(byte[] buffer)
    {
        byte[] temp = Enumerable.Repeat((byte)0x0, PAYLOAD_LENGTH).ToArray();
        for (var i = 0; i < buffer.Length; i++)
            temp[i] = buffer[i];

        return temp;
    }

    private static bool IsBetween(long item, long upper, long lower)
    {
        return item <= upper && item >= lower;
    }

    public static long FromBuffer(byte[] buffer)
    {
        var prefix = buffer[0];
        return prefix switch 
        {
            0xf8 => BitConverter.ToInt64(buffer, 1),
            0xfc => BitConverter.ToInt32(buffer, 1),
            0xfe => BitConverter.ToInt16(buffer, 1),
            0x4 => BitConverter.ToUInt32(buffer, 1),
            0x2 => BitConverter.ToUInt16(buffer, 1),
            _ => 0
        };
    }
}
