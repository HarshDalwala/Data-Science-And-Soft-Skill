-- Q5: Create delivery_agents table

CREATE TABLE delivery_agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(100),
    city VARCHAR(50),
    completed_deliveries INT
);

-- Insert sample delivery agent data
-- We have multiple agents in different cities

INSERT INTO delivery_agents
(agent_id, agent_name, city, completed_deliveries)
VALUES
(1, 'Rahul', 'Surat', 120),
(2, 'Amit', 'Surat', 150),
(3, 'Karan', 'Surat', 100),
(4, 'Jay', 'Surat', 180),

(5, 'Ravi', 'Mumbai', 200),
(6, 'Akash', 'Mumbai', 160),
(7, 'Vishal', 'Mumbai', 220),
(8, 'Nikhil', 'Mumbai', 140);


-- Display all delivery agents

SELECT *
FROM delivery_agents;


-- Q5: Rank delivery agents within each city
-- and compare each agent with the agent directly above

SELECT
    city,
    agent_id,
    agent_name,
    completed_deliveries,

    -- Rank agents separately within each city
    RANK() OVER (
        PARTITION BY city
        ORDER BY completed_deliveries DESC
    ) AS delivery_rank,

    -- Get the completed deliveries of the previous agent
    LAG(completed_deliveries) OVER (
        PARTITION BY city
        ORDER BY completed_deliveries DESC
    ) AS previous_agent_deliveries

FROM delivery_agents

-- Display city first, then rank
ORDER BY
    city,
    delivery_rank;
    
    
    
