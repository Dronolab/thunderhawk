xhost +

if [ ! -f .env ]; then
    # Get the value of DISPLAY variable
    DISPLAY_VALUE=$(echo $DISPLAY)

    # Add DISPLAY variable to .env file
    echo "DISPLAY=$DISPLAY_VALUE" >> .env

    echo "DISPLAY variable added to .env file with value: $DISPLAY_VALUE"
else
    echo ".env file already exists."
fi