import { GoogleAuthProvider, signInWithPopup } from "firebase/auth";
import { auth, db } from "../firebase/Firebase";
import { toast } from "react-toastify";
import { setDoc, doc } from "firebase/firestore";
import googleLogo from "../assets/google.png"; // Import the image here

function SignInWithGoogle() {
  const googleLogin = async () => {
    const provider = new GoogleAuthProvider();
    try {
      const result = await signInWithPopup(auth, provider);
      console.log(result);
      const user = result.user;
      if (user) {
        await setDoc(doc(db, "Users", user.uid), {
          email: user.email,
          firstName: user.displayName,
          photo: user.photoURL,
          lastName: "",
        });
        toast.success("User logged in successfully", {
          position: "top-center",
        });
        window.location.href = "/dashboard"; // Redirect after successful login
      }
    } catch (error) {
      console.error("Error during Google login:", error);
      toast.error("Login failed. Please try again.", {
        position: "top-center",
      });
    }
  };

  return (
    <div>
      <p className="continue-p">--Or continue with--</p>
      <div
        style={{ display: "flex", justifyContent: "center", cursor: "pointer" }}
        onClick={googleLogin}
      >
        <img src={googleLogo} width={"60%"} alt="Google logo" /> {/* Use the imported image */}
      </div>
    </div>
  );
}

export default SignInWithGoogle;
