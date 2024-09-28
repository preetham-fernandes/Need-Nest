import React, { useEffect, useState } from 'react';
import { db, auth } from '../../firebase/Firebase'; // Import auth
import { collection, getDocs, addDoc } from 'firebase/firestore';
import { onAuthStateChanged } from 'firebase/auth'; // Import onAuthStateChanged

const Organizations = () => {
  const [organizations, setOrganizations] = useState([]);
  const [modalOpen, setModalOpen] = useState(false);
  const [selectedOrg, setSelectedOrg] = useState(null);
  const [requestData, setRequestData] = useState({
    resourceName: '',
    quantityRequested: '',
  });
  const [loggedInUser, setLoggedInUser] = useState(null); // State for logged-in user

  // Fetch data from Firestore
  useEffect(() => {
    const fetchOrganizations = async () => {
      const usersCollection = collection(db, 'Users');
      const orgSnapshot = await getDocs(usersCollection);
      const orgList = orgSnapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));
      setOrganizations(orgList);
    };

    fetchOrganizations();

    // Get the logged-in user's info
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      if (user) {
        setLoggedInUser(user.displayName || user.email); // Use displayName or email
      } else {
        setLoggedInUser(null);
      }
    });

    return () => unsubscribe(); // Clean up the listener
  }, []);

  // Handle input changes for the modal
  const handleRequestDataChange = (e) => {
    const { name, value } = e.target;
    setRequestData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  // Handle opening the request modal
  const handleRequest = (orgId) => {
    setSelectedOrg(orgId);
    setModalOpen(true);
  };

  // Handle submitting the request
  const handleSubmitRequest = async () => {
    if (requestData.resourceName && requestData.quantityRequested && selectedOrg && loggedInUser) {
      const requestsCollection = collection(db, 'Requests');

      // Get the organization details of the selected organization
      const requestedOrg = organizations.find((org) => org.id === selectedOrg);

      if (requestedOrg) {
        // Create a new request with both 'postedBy' and 'requestedFrom'
        await addDoc(requestsCollection, {
          postedBy: loggedInUser, // Use the logged-in user's name
          requestedFrom: requestedOrg.name, // Name of the organization being requested
          quantityRequested: requestData.quantityRequested,
          requestId: Math.floor(Math.random() * 1000000), // Generate a random requestId
          resourceId: requestData.resourceName,
          status: 'pending',
        });

        // Close modal and reset request data
        setModalOpen(false);
        setRequestData({
          resourceName: '',
          quantityRequested: '',
        });
        setSelectedOrg(null);
      } else {
        alert('Selected organization not found.');
      }
    } else {
      alert('Please fill out all fields.');
    }
  };

  return (
    <div className="container mx-auto p-4">
      <h1 className="text-xl font-bold mb-4">Organization Details</h1>
      <div className="bg-white shadow-md rounded-lg overflow-hidden">
        <div className="max-h-[80vh] overflow-y-auto">
          <table className="min-w-full leading-normal">
            <thead>
              <tr>
                <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                  Name
                </th>
                <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                  Type
                </th>
                <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                  Address
                </th>
                <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                  Phone
                </th>
                <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                  Email
                </th>
                <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                  Actions
                </th>
              </tr>
            </thead>
            <tbody>
              {organizations.map((org) => (
                <tr key={org.id}>
                  <td className="px-5 py-5 border-b border-gray-200 bg-white text-base">{org.name}</td>
                  <td className="px-5 py-5 border-b border-gray-200 bg-white text-base">{org.type}</td>
                  <td className="px-5 py-5 border-b border-gray-200 bg-white text-base">{org.address}</td>
                  <td className="px-5 py-5 border-b border-gray-200 bg-white text-base">{org.phone}</td>
                  <td className="px-5 py-5 border-b border-gray-200 bg-white text-base">{org.email}</td>
                  <td className="px-5 py-5 border-b border-gray-200 bg-white text-base">
                    <button
                      onClick={() => handleRequest(org.id)}
                      className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
                    >
                      Request
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Modal for Requesting Resources */}
      {modalOpen && (
        <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 p-4">
          <div className="bg-white p-6 rounded shadow-lg transition-all transform scale-100">
            <h2 className="text-lg font-semibold mb-4">Request Resource</h2>
            <input
              type="text"
              name="resourceName"
              placeholder="Resource Name"
              value={requestData.resourceName}
              onChange={handleRequestDataChange}
              className="mb-2 w-full border border-gray-300 rounded px-2"
            />
            <input
              type="number"
              name="quantityRequested"
              placeholder="Quantity Requested"
              value={requestData.quantityRequested}
              onChange={handleRequestDataChange}
              className="mb-2 w-full border border-gray-300 rounded px-2"
            />
            <div className="flex justify-between mt-4">
              <button
                onClick={handleSubmitRequest}
                className="px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600"
              >
                Submit Request
              </button>
              <button
                onClick={() => setModalOpen(false)}
                className="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600"
              >
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default Organizations;
