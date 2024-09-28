import React from 'react';
import { Bar, Line, Pie, Doughnut } from 'react-chartjs-2';
import { Chart as ChartJS, LineElement, PointElement, CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend, ArcElement } from 'chart.js';

// Register the components
ChartJS.register(CategoryScale, LinearScale, LineElement, PointElement, BarElement, Title, Tooltip, Legend, ArcElement);

const DashboardPage = () => {
  // Sample data for the charts
  const sampleData = {
    labels: ['January', 'February', 'March', 'April'],
    datasets: [
      {
        label: 'Sample Dataset',
        data: [65, 59, 80, 81],
        backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56'],
        hoverBackgroundColor: ['#FF6384', '#36A2EB', '#FFCE56'],
      },
    ],
  };
  const options = {
    responsive: true,
    maintainAspectRatio: false, // Allow height flexibility
  };

  return (
    <div className="h-screen overflow-y-auto p-4"> {/* Scrollable wrapper */}
      <div className="grid grid-cols-2 gap-4">
        <div className="bg-white p-4 shadow rounded">
          <h2 className="text-xl font-bold">Bar Chart</h2>
          <Bar data={sampleData} />
        </div>
        <div className="bg-white p-4 shadow rounded">
          <h2 className="text-xl font-bold">Line Chart</h2>
          <Line data={sampleData} />
        </div>
        <div className="bg-white p-4 shadow rounded">
          <h2 className="text-xl font-bold">Pie Chart</h2>
          <Pie data={sampleData} />
        </div>
        <div className="bg-white p-4 shadow rounded">
          <h2 className="text-xl font-bold">Doughnut Chart</h2>
          <Doughnut data={sampleData} />
        </div>
      </div>
    </div>
  );
};

export default DashboardPage;
