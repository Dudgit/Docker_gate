import subprocess
def main(start_border,end_border,step_size):
    with open("output.log", "a") as output:
        subprocess.call("docker build -t dude -f docker-image/Dockerfile .", shell=True, stdout=output, stderr=output)
        for width in range(start_border,end_border,step_size):
            subprocess.call(f"docker run -v $(pwd)/output/:/output -it dude -dt --simulation water_phantom -wpt {width} --primaries 100000", shell=True, stdout=output, stderr=output)


if __name__ == '__main__':
    main(30,3000,5)