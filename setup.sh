xhost +

if [ ! -f .env ]; then
    DISPLAY_VALUE=$(echo $DISPLAY)

    # Add DISPLAY variable to .env file
    echo "DISPLAY=$DISPLAY_VALUE" >> .env

else
    echo ".env file already exists."
fi