import { createUserWithEmailAndPassword } from "firebase/auth";
import React, { useState } from "react";
import { auth, db } from "../firebase/Firebase";
import { setDoc, doc } from "firebase/firestore";
import { toast } from "react-toastify";

function Register() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [organizationName, setOrganizationName] = useState("");
  const [organizationType, setOrganizationType] = useState("");
  const [loading, setLoading] = useState(false); // Loading state

  const handleRegister = async (e) => {
    e.preventDefault();
    setLoading(true); // Set loading state to true
    try {
      const userCredential = await createUserWithEmailAndPassword(auth, email, password);
      const user = userCredential.user; // Access user from credential
      console.log(user);
      if (user) {
        await setDoc(doc(db, "Users", user.uid), {
          email: user.email,
          name: organizationName, // Save organization name as 'name'
          type: organizationType, // Save organization type as 'type'
          photo: ""
        });
      }
      console.log("User Registered Successfully!!");
      toast.success("User Registered Successfully!!", {
        position: "top-center",
      });
      // Redirect or perform additional actions after registration
    } catch (error) {
      console.log(error.message);
      toast.error(error.message, {
        position: "bottom-center",
      });
    } finally {
      setLoading(false); // Reset loading state
    }
  };

  return (
    <div className="flex items-center justify-center h-screen bg-gray-100">
      <form
        onSubmit={handleRegister}
        className="bg-white shadow-md rounded px-8 py-6 w-96"
      >
        <h3 className="text-2xl font-semibold mb-6 text-center">Sign Up</h3>

        <div className="mb-4">
          <label htmlFor="organizationName" className="block text-sm font-medium text-gray-700">
            Organization Name
          </label>
          <input
            type="text"
            id="organizationName"
            className="mt-1 block w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            placeholder="Organization name"
            value={organizationName}
            onChange={(e) => setOrganizationName(e.target.value)}
            required
          />
        </div>

        <div className="mb-4">
          <label htmlFor="organizationType" className="block text-sm font-medium text-gray-700">
            Organization Type
          </label>
          <input
            type="text"
            id="organizationType"
            className="mt-1 block w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            placeholder="Organization type"
            value={organizationType}
            onChange={(e) => setOrganizationType(e.target.value)}
            required
          />
        </div>

        <div className="mb-4">
          <label htmlFor="email" className="block text-sm font-medium text-gray-700">
            Email Address
          </label>
          <input
            type="email"
            id="email"
            className="mt-1 block w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            placeholder="Enter email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />
        </div>

        <div className="mb-4">
          <label htmlFor="password" className="block text-sm font-medium text-gray-700">
            Password
          </label>
          <input
            type="password"
            id="password"
            className="mt-1 block w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            placeholder="Enter password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
          />
        </div>

        <div className="d-grid mb-4">
          <button
            type="submit"
            className={`w-full p-2 rounded-md text-white ${
              loading ? "bg-blue-400" : "bg-blue-600 hover:bg-blue-700"
            }`}
            disabled={loading} // Disable button while loading
          >
            {loading ? "Loading..." : "Sign Up"}
          </button>
        </div>

        <p className="text-center text-sm text-gray-500 mb-4">
          Already registered? <a href="/login" className="text-blue-600 hover:underline">Login</a>
        </p>
      </form>
    </div>
  );
}

export default Register;
