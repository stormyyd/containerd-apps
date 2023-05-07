          
Upgrade {{ .appname }} to version {{ .version }}.

You can pull this version by:

```bash
docker pull {{ .imagename }}:{{ .version }}-auto
```

Once the testing is complete, you can retag the image as `latest`, and push it to DockerHub:

```bash
docker tag {{ .imagename }}:{{ .version }}-auto {{ .imagename }}:latest
docker tag {{ .imagename }}:{{ .version }}-auto {{ .imagename }}:{{ .version }}
docker push {{ .imagename }}:latest
docker push {{ .imagename }}:{{ .version }}
```

This PR is auto-generated.
