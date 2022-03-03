import subprocess
def main(rotstart=0,rotend=180,rotstep=1,bdx = 25, bdy = 50 ):
    with open("output.log", "a") as output:
        subprocess.call("docker build -t water_phantom_xy -f docker-image/Dockerfile .", shell=True, stdout=output, stderr=output)
        for r in range(rotstart,rotend,rotstep):
            myexecution = "docker run -v $(pwd)/output/rotations/:/output -d --rm -it water_phantom_xy -dt --simulation water_phantom --beam_energy 230 -bdx 0 -bdy 0 -wpm box -wpt 200 -wpx 50 -wpy 40 -pra " +str(r) + " --primaries 10000 --extract-edep --output-format npy" #need to make it multiple lines

            subprocess.call(myexecution,shell=True, stdout=output, stderr=output)


if __name__ == '__main__':
    main(0,180,1)

