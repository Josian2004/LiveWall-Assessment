# Assessment for LiveWall
## About
This app was made as an assessment for a Mobile Development Internship at LiveWall Tilburg.
You can see a detailed summary of the app on my portfolio.

## Installation instructions 
The app is not available in the AppStore so you need to clone this repository and change some things to make it work.

### Step 1
Clone this repository and open it in Xcode.

### Step 2
You probably need to change the Bundle Identifier of the app, it is now *josian.vanefferen.LiveWallAssessment*. This is probably reserved for my account so change it to something else.

### Step 3
The app uses the Spotify API for its data so you need an ID and Secret to request a token, it would be a security risk to add these to the repo so you need to have your own.  
Create an application in the [Spotify Developer Dashboard](https://developer.spotify.com/dashboard) and add *https://josian.nl* as a redirect URL. You also need to add your Spotify Account as a test user.

### Step 4
In Xcode, create a configuration file called *Secrets.xcconfig* and add it in the root folder of the project.  
Add this to *Secrets.xcconfig* and fill in the placeholders, don't use ""!
```
Spotify_ClientSecret = CLIENT_SECRET
Spotify_ClientId = CLIENT_ID
```

### Step 5
The app should now build and launch on your test device, if it still can't find the secret and id, make sure that your project uses *Secrets.xcconfig* as a configuration during debug and release. This can be found under LiveWallAssessment.xcodeproj -> configurations.  



If you're still facing issues with the installation, feel free to contact me!
