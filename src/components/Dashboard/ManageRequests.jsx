import React, { useEffect, useState } from 'react';
import { db, auth } from '../../firebase/Firebase';
import { collection, getDocs } from 'firebase/firestore';
import { onAuthStateChanged } from 'firebase/auth';

const ManageRequests = () => {
  const [sentRequests, setSentRequests] = useState([]);
  const [receivedRequests, setReceivedRequests] = useState([]);
  const [loggedInUser, setLoggedInUser] = useState(null);

  useEffect(() => {
    const fetchRequests = async () => {
      const requestsCollection = collection(db, 'Requests');
      const requestsSnapshot = await getDocs(requestsCollection);
      const requestsList = requestsSnapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));

      if (loggedInUser) {
        // Filter requests based on logged-in user
        const sent = requestsList.filter(request => request.postedBy === loggedInUser.name);
        const received = requestsList.filter(request => request.requestedFrom === loggedInUser.name);

        setSentRequests(sent);
        setReceivedRequests(received);
      }
    };

    // Get the logged-in user's info
    const unsubscribe = onAuthStateChanged(auth, async (user) => {
      if (user) {
        const userCollection = collection(db, 'Users');
        const userSnapshot = await getDocs(userCollection);
        const userList = userSnapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
        const currentUser = userList.find(u => u.email === user.email); // Assuming email is unique
        setLoggedInUser(currentUser);
      } else {
        setLoggedInUser(null);
      }
    });

    fetchRequests();

    return () => unsubscribe(); // Clean up the listener
  }, [loggedInUser]);

  return (
    <div className="container mx-auto p-4">
      <h2 className="text-lg font-semibold mb-2">Requests Sent</h2>
      <div className="bg-white shadow-md rounded-lg overflow-hidden mb-4">
        <table className="min-w-full leading-normal">
          <thead>
            <tr>
              <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                Request ID
              </th>
              <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                Requested From
              </th>
              <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                Quantity Requested
              </th>
              <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                Status
              </th>
            </tr>
          </thead>
          <tbody>
            {sentRequests.map((request) => (
              <tr key={request.id}>
                <td className="px-5 py-5 border-b border-gray-200 bg-white text-base">{request.requestId}</td>
                <td className="px-5 py-5 border-b border-gray-200 bg-white text-base">{request.requestedFrom}</td>
                <td className="px-5 py-5 border-b border-gray-200 bg-white text-base">{request.quantityRequested}</td>
                <td className="px-5 py-5 border-b border-gray-200 bg-white text-base">{request.status}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <h2 className="text-lg font-semibold mb-2">Requests Received</h2>
      <div className="bg-white shadow-md rounded-lg overflow-hidden">
        <table className="min-w-full leading-normal">
          <thead>
            <tr>
              <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                Request ID
              </th>
              <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                Posted By
              </th>
              <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                Quantity Requested
              </th>
              <th className="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">
                Status
              </th>
            </tr>
          </thead>
          <tbody>
            {receivedRequests.map((request) => (
              <tr key={request.id}>
                <td className="px-5 py-5 border-b border-gray-200 bg-white text-base">{request.requestId}</td>
                <td className="px-5 py-5 border-b border-gray-200 bg-white text-base">{request.postedBy}</td>
                <td className="px-5 py-5 border-b border-gray-200 bg-white text-base">{request.quantityRequested}</td>
                <td className="px-5 py-5 border-b border-gray-200 bg-white text-base">{request.status}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default ManageRequests;