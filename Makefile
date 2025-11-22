CC = armv7a-linux-androideabi19-clang

all: oled_hijack.so device_webhook.so device_webhook_client sms_webhook.so sms_webhook_client

oled_hijack.so: oled_hijack.c oled_paint.c oled_widgets.c oled_process.c oled.h oled_font.h
	$(CC) -W -shared -ldl -fPIC -O2 -s -o oled_hijack.so oled_hijack.c oled_paint.c oled_process.c oled_widgets.c $(CFLAGS)

oled_hijack_debug.so: oled_hijack.c oled_paint.c oled_widgets.c oled_process.c oled.h oled_font.h
	$(CC) -W -shared -ldl -fPIC -O0 -ggdb -o oled_hijack_debug.so oled_hijack.c oled_paint.c oled_process.c oled_widgets.c $(CFLAGS)

device_webhook.so: web_hook.c
	$(CC) -shared -ldl -fPIC -O2 -s -pthread -DHOOK -DSOCK_NAME='"/var/device_webhook"' -o device_webhook.so web_hook.c $(CFLAGS)

device_webhook_client: web_hook.c
	$(CC) -fPIC -O2 -DCLIENT -DSOCK_NAME='"/var/device_webhook"' -s -o device_webhook_client web_hook.c $(CFLAGS)

sms_webhook.so: web_hook.c
	$(CC) -shared -ldl -fPIC -O2 -s -pthread -DHOOK -DSOCK_NAME='"/var/sms_webhook"' -o sms_webhook.so web_hook.c $(CFLAGS)

sms_webhook_client: web_hook.c
	$(CC) -fPIC -O2 -DCLIENT -DSOCK_NAME='"/var/sms_webhook"' -s -o sms_webhook_client web_hook.c $(CFLAGS)
