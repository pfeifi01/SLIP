void send_packet(char *p, int len) {
    send_char(END);
    while (len--) {
        switch (*p) {
            case END:
                send_char(ESC);
                send_char(ESC_END);
                break;
            case ESC:
                send_char(ESC);
                send_char(ESC_ESC);
                break;
            default:
                send_char(*p);
        }
        p++;
    }
    send_char(END);
}

