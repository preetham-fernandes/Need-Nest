import React, { useState, useEffect } from 'react';
import { db } from '../../firebase/Firebase';
import { collection, getDocs } from 'firebase/firestore';

const MyAlerts = () => {
  const [alerts, setAlerts] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchAlerts = async () => {
      try {
        const alertsCollection = collection(db, 'Alerts');
        const alertSnapshot = await getDocs(alertsCollection);
        const alertList = alertSnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
        console.log("Fetched alerts: ", alertList);
        setAlerts(alertList);
      } catch (error) {
        console.error("Error fetching alerts: ", error);
        setError("Failed to load alerts.");
      }
    };

    fetchAlerts();
  }, []);

  const formatTimestamp = (timestamp) => {
    if (timestamp && timestamp.seconds) {
      const date = new Date(timestamp.seconds * 1000);
      return date.toLocaleString();
    }
    return "";
  };

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col items-center p-5">
      <h1 className="text-4xl font-bold text-center mb-8 text-blue-600">Recent Alerts</h1>
      {error && <p className="text-red-500 mb-4">{error}</p>}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        {alerts.map(alert => (
          <div key={alert.id} className="bg-white p-5 rounded-lg shadow-lg transform transition-transform hover:scale-105 hover:shadow-2xl">
            <div className="flex items-center mb-3">
              <h3 className="font-semibold text-xl text-blue-500">{alert.contactPerson?.name || 'N/A'}</h3>
            </div>
            <p className="text-sm text-gray-600">{alert.location}</p>
            <p className="mt-3 text-gray-700">{alert.description}</p>
            <p className="mt-3 text-gray-500 text-sm">Date: <span className="font-medium">{formatTimestamp(alert.dateTime)}</span></p>
            <p className="mt-2 text-gray-500 text-sm">Posted By: <span className="font-medium">{alert.postedBy}</span></p>
            <p className="mt-2 text-gray-500 text-sm">Volunteers Needed: <span className="font-medium">{alert.volunteersNeeded}</span></p>
            <button className="mt-4 w-full bg-blue-600 text-white py-2 rounded-md hover:bg-blue-700 transition duration-300">
              Edit
            </button>
          </div>
        ))}
      </div>
    </div>
  );
};

export default MyAlerts;
