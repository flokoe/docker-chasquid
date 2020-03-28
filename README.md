# docker-chasquid

*Warning:* This repository is work in progress. Use at your own risk!

For a project of mine I needed a simple and fast solution of an send-only SMTP server.
You could use this image as a receiving SMTP-Server, but this is not the goal of this project.
If you want a full fledged mail setup in docker, I suggest to have a look at the [Email Section of Awesome-Selfhosted](https://github.com/awesome-selfhosted/awesome-selfhosted#email)

Of course there solutions like Exim and Postfix, but they felt a bit overkill for what I wanted to do.
Nevertheless they are still great Software!

This project uses [chasquid](https://blitiri.com.ar/p/chasquid/), which is a SMTP server written in go and with a focus on simplicity, security, and ease of operation.

# Usage

Currently there are only two environment variables which are mandatory:

- `SMTP_USER`
- `SMTP_USER_PASS`

`SMTP_USER` needs to be in the form of `user@domain`. Just use the domain you want to send emails from.

Furthermore, you have to mount certificates, because chasquid won't work without them. Just mount them to `/etc/chasquid/certs` within the container.

The directory of the certificates has to have the following structure:

```plain
certs/
  yourdomain.tld/
    fullchain.pem
    privkey.pem
```

If you use Let's Encrypt you have to mount `/etc/letsencrypt/live` to `/etc/chasquid/certs` and `/etc/letsencrypt/archive` to `/etc/chasqui/archive`.

To start chasquid with letsencrypt exectue the following command:

```bash
docker run -ti -e SMTP_USER=user@domain -e SMTP_USER_PASS=yourpassword -v /etc/letsencrypt/live:/etc/chasquid/certs -v /etc/letsencrypt/archive:/etc/chasquid/archive chasquid
```

# To Do

- Add support for all commandline flags and config options
- Add tests for environment variables

## License

This repository is available under the [MIT license](LICENSE).

