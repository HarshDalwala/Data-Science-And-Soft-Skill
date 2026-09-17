{
 "cells": [
  {
   "cell_type": "raw",
   "id": "c15da475-70e4-4a6a-a484-d5d3793c622e",
   "metadata": {},
   "source": [
    "1. Create a Python script called playlist_stats.py that takes a list of daily Spotify song play counts (e.g., [120, 135, 150, 200, 120, 90, 200]) and calculates the mean (average) number of plays."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "c8c9026d-0795-4e2e-b52d-769049e3cfb8",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Mean number of plays: 145.0\n"
     ]
    }
   ],
   "source": [
    "plays = [120, 135, 150, 200, 120, 90, 200]\n",
    "\n",
    "mean = sum(plays) / len(plays)\n",
    "\n",
    "print(\"Mean number of plays:\", mean)"
   ]
  },
  {
   "cell_type": "raw",
   "id": "62ab2cf1-8d5c-4440-8d6c-3a51d2b85e00",
   "metadata": {},
   "source": [
    "2. Given the following array of delivery times (in minutes) for Zomato orders: [30, 25, 40, 35, 30, 45, 30], write code to find the median delivery time and print it."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "9adec225-42b5-4de8-8346-ec43fc0e0d58",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Sorted delivery times: [25, 30, 30, 30, 35, 40, 45]\n",
      "Median delivery time: 30 minutes\n"
     ]
    }
   ],
   "source": [
    "delivery_times = [30, 25, 40, 35, 30, 45, 30]\n",
    "\n",
    "delivery_times.sort()\n",
    "\n",
    "n = len(delivery_times)\n",
    "median = delivery_times[n // 2]\n",
    "\n",
    "print(\"Sorted delivery times:\", delivery_times)\n",
    "print(\"Median delivery time:\", median, \"minutes\")"
   ]
  },
  {
   "cell_type": "raw",
   "id": "206bf64b-9376-4bc2-bbe4-8da330464fc5",
   "metadata": {},
   "source": [
    "3. Write a function most_common_rating(ratings) that takes a list of Flipkart product ratings (e.g., [5, 4, 4, 3, 5, 4, 2, 4]) and returns the mode (most frequent rating)."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "270583ff-208a-45d2-817b-d0aace910e3a",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Most common rating: 4\n"
     ]
    }
   ],
   "source": [
    "def most_common_rating(ratings):\n",
    "    return max(set(ratings), key=ratings.count)\n",
    "\n",
    "ratings = [5, 4, 4, 3, 5, 4, 2, 4]\n",
    "\n",
    "mode = most_common_rating(ratings)\n",
    "\n",
    "print(\"Most common rating:\", mode)"
   ]
  },
  {
   "cell_type": "raw",
   "id": "726f2016-04f6-4092-bfa9-dae89079aaf7",
   "metadata": {},
   "source": [
    "4. Given three lists representing YouTube video views for three different channels, compare the mean, median, and mode for each channel, and decide which channel's data is most affected by outliers.<br><br><em><strong>Hint:</strong> Try using one list with a very high value (e.g., [100, 120, 110, 105, 5000]) to see the effect on mean vs median.</em>"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "bd880a2e-1bdd-41ba-9254-1c32c12ab376",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Channel 1\n",
      "Mean: 113.0\n",
      "Median: 105\n",
      "Mode: 100\n",
      "\n",
      "Channel 2\n",
      "Mean: 206.0\n",
      "Median: 205\n",
      "Mode: 200\n",
      "\n",
      "Channel 3\n",
      "Mean: 285.0\n",
      "Median: 110\n",
      "Mode: 110\n",
      "\n"
     ]
    }
   ],
   "source": [
    "channel_1 = [100, 110, 105, 150, 100]\n",
    "channel_2 = [200, 210, 205, 215, 200]\n",
    "channel_3 = [100, 110, 105, 1000, 110]\n",
    "\n",
    "# Function to calculate statistics\n",
    "def calculate_stats(data):\n",
    "    mean = sum(data) / len(data)\n",
    "    \n",
    "    sorted_data = sorted(data)\n",
    "    median = sorted_data[len(data) // 2]\n",
    "    \n",
    "    mode = max(set(data), key=data.count)\n",
    "    \n",
    "    return mean, median, mode\n",
    "\n",
    "\n",
    "# Calculate statistics for each channel\n",
    "for name, data in [\n",
    "    (\"Channel 1\", channel_1),\n",
    "    (\"Channel 2\", channel_2),\n",
    "    (\"Channel 3\", channel_3)\n",
    "]:\n",
    "    mean, median, mode = calculate_stats(data)\n",
    "    \n",
    "    print(name)\n",
    "    print(\"Mean:\", mean)\n",
    "    print(\"Median:\", median)\n",
    "    print(\"Mode:\", mode)\n",
    "    print()"
   ]
  },
  {
   "cell_type": "raw",
   "id": "219983d6-5ccd-4e2f-a2be-ceb521327105",
   "metadata": {},
   "source": [
    "5. Pick any real dataset from Kaggle or UCI (e.g., IPL player runs, Swiggy restaurant ratings, or movie box office collections), load it using pandas, and display the mean, median, and mode for one numeric column of your choice."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "972cbb76-41b1-4ea4-b600-84a3549e173c",
   "metadata": {},
   "outputs": [],
   "source": [
    "import pandas as pd"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "989fd7ea-b34c-4b61-9577-e3868047203c",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div>\n",
       "<style scoped>\n",
       "    .dataframe tbody tr th:only-of-type {\n",
       "        vertical-align: middle;\n",
       "    }\n",
       "\n",
       "    .dataframe tbody tr th {\n",
       "        vertical-align: top;\n",
       "    }\n",
       "\n",
       "    .dataframe thead th {\n",
       "        text-align: right;\n",
       "    }\n",
       "</style>\n",
       "<table border=\"1\" class=\"dataframe\">\n",
       "  <thead>\n",
       "    <tr style=\"text-align: right;\">\n",
       "      <th></th>\n",
       "      <th>sepal_length</th>\n",
       "      <th>sepal_width</th>\n",
       "      <th>petal_length</th>\n",
       "      <th>petal_width</th>\n",
       "      <th>species</th>\n",
       "    </tr>\n",
       "  </thead>\n",
       "  <tbody>\n",
       "    <tr>\n",
       "      <th>0</th>\n",
       "      <td>5.1</td>\n",
       "      <td>3.5</td>\n",
       "      <td>1.4</td>\n",
       "      <td>0.2</td>\n",
       "      <td>setosa</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>1</th>\n",
       "      <td>4.9</td>\n",
       "      <td>3.0</td>\n",
       "      <td>1.4</td>\n",
       "      <td>0.2</td>\n",
       "      <td>setosa</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>2</th>\n",
       "      <td>4.7</td>\n",
       "      <td>3.2</td>\n",
       "      <td>1.3</td>\n",
       "      <td>0.2</td>\n",
       "      <td>setosa</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>3</th>\n",
       "      <td>4.6</td>\n",
       "      <td>3.1</td>\n",
       "      <td>1.5</td>\n",
       "      <td>0.2</td>\n",
       "      <td>setosa</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>4</th>\n",
       "      <td>5.0</td>\n",
       "      <td>3.6</td>\n",
       "      <td>1.4</td>\n",
       "      <td>0.2</td>\n",
       "      <td>setosa</td>\n",
       "    </tr>\n",
       "  </tbody>\n",
       "</table>\n",
       "</div>"
      ],
      "text/plain": [
       "   sepal_length  sepal_width  petal_length  petal_width species\n",
       "0           5.1          3.5           1.4          0.2  setosa\n",
       "1           4.9          3.0           1.4          0.2  setosa\n",
       "2           4.7          3.2           1.3          0.2  setosa\n",
       "3           4.6          3.1           1.5          0.2  setosa\n",
       "4           5.0          3.6           1.4          0.2  setosa"
      ]
     },
     "execution_count": 14,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "url = \"https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv\"\n",
    "\n",
    "df = pd.read_csv(url)\n",
    "\n",
    "df.head()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "38f3e128-8891-4751-b1e8-49e610c25ed6",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Mean: 5.843333333333334\n",
      "Median: 5.8\n",
      "Mode: 5.0\n"
     ]
    }
   ],
   "source": [
    "mean = df[\"sepal_length\"].mean()\n",
    "median = df[\"sepal_length\"].median()\n",
    "mode = df[\"sepal_length\"].mode()[0]\n",
    "\n",
    "print(\"Mean:\", mean)\n",
    "print(\"Median:\", median)\n",
    "print(\"Mode:\", mode)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "2f2638f9-d630-4d50-944c-d8163b8b711e",
   "metadata": {},
   "source": [
    "## Task 5: Mean, Median and Mode Using a Real Dataset\n",
    "\n",
    "I used the Iris dataset and selected the `sepal_length` column for analysis.\n",
    "\n",
    "- Mean: 5.84\n",
    "- Median: 5.8\n",
    "- Mode: 5.0\n",
    "\n",
    "The mean represents the average sepal length, the median represents the middle value, and the mode represents the most frequently occurring value."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.13.9"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
