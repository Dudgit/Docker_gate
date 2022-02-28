import subprocess
def main(start_border,end_border,step_size):
    with open("output.log", "a") as output:
        subprocess.call("docker build -t water_phantom_xy -f docker-image/Dockerfile .", shell=True, stdout=output, stderr=output)
        for bdx in range(start_border,end_border,step_size):
            for bdy in range(start_border,end_border,step_size):
                myexecution = "docker run -v /home/bdudas/Bence/D2/output:/output -d --rm -it water_phantom_xy -dt --simulation water_phantom --beam_energy 230 -wpm sphere -wpt 25 -bdx " + str(bdx) + " -bdy " + str(bdy) + " --primaries 10000"
                subprocess.call(myexecution,
                shell=True, stdout=output, stderr=output)


if __name__ == '__main__':
    main(0,15,5)
