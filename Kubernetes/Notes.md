## **Explain the difference between a container, a pod, and a deployment in Kubernetes.**

- A container is a package with the program to execute and all its dependencies, such as the code, runtime, system libraries, etc., bound together in a box. You can create containers using any container platform like Docker. To run a container on Docker, you provide the specifications to run this container on the command line.

- Kubernetes modifies this process and brings an enterprise model to it. Instead of writing all of these things in the command line, you can create a YAML manifest and define all of these things inside this YAML manifest. A pod YAML manifest is nothing but a running specification of your Docker container. The only difference here is that a pod can be a single or multiple containers. You can create multiple containers in a pod if you have an application that is dependent on another application without which it cannot run.

- Finally, what is a deployment? A deployment is used to manage and scale your pods. If you can deploy an application as a container in Kubernetes using a pod, what is the purpose of using a deployment? The answer is simple: One of the reasons to move from container platforms like Docker to Kubernetes is the auto-healing and auto-scaling behavior that Kubernetes offers. A pod, which is similar to a container, does not have the capability to implement auto-healing and auto-scaling. This is where deployments come in. Deployments in Kubernetes offer the ability to implement auto-healing and auto-scaling.
  Instead of deploying your applications as pods in Kubernetes, you should deploy them as deployments. A deployment will create an intermediate resource called a replica set, which will then create pods. The advantage of using a deployment is that you can specify the desired number of replicas for your pods, allowing you to easily scale your application.

- The replica set is a Kubernetes controller that ensures that the desired state of your application, as specified in the deployment YAML manifest, is always maintained on the cluster. This includes implementing the  **auto-healing** and  **auto-scaling** behavior of your pods.
  If you specify in your deployment YAML manifest that you want a certain number of replicas for your pods, the replica set will ensure that this number of replicas is always running. If a pod is deleted or fails, the replica set will automatically create a new pod to maintain the desired number of replicas. Similarly, if you want to increase or decrease the number of replicas, you can simply update the deployment YAML manifest and the replica set will automatically scale the number of pods accordingly.




## **Difference between Deployment and ReplicaSet--- shortnotes**
- In Kubernetes, a Deployment is a higher-level resource that manages the desired state of your application by specifying the desired number of replicas for your pods. It provides features like rolling updates and rollbacks to help you manage your application at scale.
When you create a Deployment, it creates an intermediate resource called a ReplicaSet. 

- The ReplicaSet is responsible for ensuring that the desired number of replicas specified in the Deployment is always maintained. It does this by creating and deleting pods as necessary to match the desired state.

- In summary, a Deployment is a higher-level resource that manages the desired state of your application, while a ReplicaSet is an intermediate resource created by the Deployment that ensures that the desired number of replicas is always maintained. The main difference between the two is that a Deployment provides additional features like rolling updates and rollbacks, while a ReplicaSet is focused on maintaining the desired number of replicas.
- In k8s, there is a concept called controllers, main work of controller is to watching the POD is running in desired state or not. 
	If not it sends the message to scheduler to create a new resource to achieve the desired state. -> One of the controllers is called "Deployment".
	"Deployment" first creates "replica set (actual controller)" managed by "deployment" and replica set creates and manages the POD.


- Deployments and ReplicaSets are both Kubernetes objects that are used to manage Pods. However, they have different purposes and capabilities.
  Deployments are a higher-level abstraction than ReplicaSets. They provide a way to manage a set of Pods that are running the same application. Deployments can be used to 
  create, update, and delete Pods in a controlled way. They can also be used to perform rolling updates, which allows you to update your Pods one at a time without 
  interrupting your users.
- ReplicaSets are a lower-level abstraction than Deployments. They are used to ensure that a specified number of Pods are running. ReplicaSet controllers will create new Pods 
  if the number of Pods falls below the desired number, and they will delete Pods if the number of Pods exceeds the desired number.

- In summary, Deployments are a more sophisticated way to manage Pods than ReplicaSets. They provide features such as rolling updates and rollbacks that are not available with ReplicaSets. However, ReplicaSets are more lightweight than Deployments, and they can be used for simple Pod management tasks.

   ### **Which one should you use?**
      The choice of whether to use a Deployment or a ReplicaSet depends on your specific needs. If you need to manage a set of Pods that are running the same application, and 
      you need to be able to perform rolling updates, then you should use a Deployment. If you only need to ensure that a specified number of Pods are running, then you can 
      use a ReplicaSet.

## **Difference between Auto healing and Auto scaling ?**
- Auto healing is the process of automatically replacing unhealthy Pods. A Pod is considered unhealthy if it fails to respond to health checks. When a Pod is unhealthy, the auto healing controller will create a new Pod to replace it. This ensures that your application is always available, even if a Pod fails.

- Auto scaling is the process of automatically adjusting the number of Pods in a Deployment. This is done based on the load on your application. If the load on your application increases, the auto scaling controller will create new Pods to handle the load. If the load on your application decreases, the auto scaling controller will delete Pods to reduce costs.

- In real time, auto healing and auto scaling work together to ensure that your application is always available and performing well. If a Pod fails, auto healing will replace the Pod. If the load on your application increases, auto scaling will create new Pods to handle the load. If the load on your application decreases, auto scaling will delete Pods to reduce costs.

### **Here is a table that summarizes the key differences between auto healing and auto scaling:**

  |**Feature**  |     **Auto healing**         |         **Auto scaling**            |
  |---|---|---|
  | Purpose     | Replace unhealthy Pods	     | Adjust the number of Pods           |
  | Trigger     | Unhealthy Pods               | Load on the application             |
  | Action      | Create new Pods              | Delete or create Pods               |  
  | Outcome	    | Always available application |	Performance optimized application  |








  
