import subprocess
import itertools as it


def create_execution(bdx = 0,bdy = 0,wpt = 175,wpx = 50,wpy = 40,pra = 0):
    myexecution = "docker run -v $(pwd)/output/:/output"
    myexecution += " -d --rm -it gate_module -dt"
    myexecution += " --phantom ctp404 --beam_energy 230"
    myexecution += " -bdx " + str(bdx)
    myexecution += " -bdy " + str(bdy)
#    myexecution += " -wpm box"
#    myexecution += " -wpt "+ str(wpt)
#    myexecution += " -wpx "+str(wpx)
#    myexecution += " -wpy "+str(wpy)
    myexecution += " -pra "+str(pra)
    myexecution += " --primaries 100 --extract-edep --output-format npy"
    return myexecution

def main(
            bdxrange = 0,bdyrange = 0
            ,translation_stepsize = 2
            ,wpt = 175,wpx = 50,wpy = 40
            ,pra_range = 0
            ,translate = False,rotate = False,translate_and_rotate = False
            ):
    """
    Description:  
    ------------  

    This function will run the Gate simulation, with specific angle range and translation range.  
    TODO: Make it work with command line commands and with and fixed parameters.  
    Version: 2

    Args:  
    -----  

    - bdxrange: translation on x axis  

    - bdyrange: translation on y axis  
    
    - wpt: thickness of the water phantom  
    
    - wpx: size of water phantom in x range  
    
    - wpy: size of water phantom in y range  
    
    - pra_range: range of rotations  
    
    - translate: do translation in the simulation or not  
    
    - rotate: do rotation or not  
    
    - translate_and_rotate: do translation and rotation  

    Output:  
    -------  
    
    Creates outputs specified before.


    """
    with open("output.log", "a") as output:
        subprocess.call("docker build -t water_phantom_xy -f docker-image/Dockerfile .", shell=True, stdout=output, stderr=output)
        for pra, bdx in it(
        range(pra_range)
        ,range(-bdxrange,bdxrange,translation_stepsize)):

            combined_execution = create_execution(bdx,0,wpt,wpx,wpy,pra)
            subprocess.call(combined_execution,shell=True, stdout=output, stderr=output)

        """
        if translate:
            for bdx,bdy in it.product(range(bdxrange),range(bdxrange)):
                    translate_command = create_execution(bdx,bdy,wpt,wpx,wpy,0)
                    subprocess.call(translate_command,shell=True, stdout=output, stderr=output)

        if rotate:
            for pra in range(pra_range):
                rotate_command = create_execution(0,0,wpt,wpx,wpy,pra)
                subprocess.call(rotate_command,shell=True, stdout=output, stderr=output)

        if translate_and_rotate:
        """



if __name__ == '__main__':
    main(bdxrange=2,translation_stepsize=1,pra_range=2)