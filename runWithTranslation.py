import subprocess
def main(bdxrange=50,bdyrange=40):
    with open("output.log", "a") as output:
        subprocess.call("docker build -t water_phantom_xy -f docker-image/Dockerfile .", shell=True, stdout=output, stderr=output)
        for bdx in range(bdxrange):
            for bdy in range(bdyrange):
                myexecution = "docker run -v $(pwd)/output/translations/:/output"
                myexecution += " -d --rm -it water_phantom_xy -dt"
                myexecution += " --simulation water_phantom --beam_energy 230"
            
                myexecution +=" -bdx " + str(bdx)
                myexecution +=" -bdy " + str(bdy)
            
                myexecution +=" -wpm box -wpt 200 -wpx 50 -wpy 40 -pra 0 --primaries 10000 --extract-edep --output-format npy"
                subprocess.call(myexecution,shell=True, stdout=output, stderr=output)


if __name__ == '__main__':
    main()