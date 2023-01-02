#!/bin/bash
echo "Please enter the number of pods you want to deploy for Keptn"
read count
echo $count
#Start keptn: with 3 nodes
kubectl create -f keptn-rc.yaml && kubectl scale rc keptn-rc --replicas=$count
#Check output:
kubectl get po -o wide
echo 
while true; do    
    read -p "Do you want to scalup Pods? [y for Yes  ;  n for No  ;  q  for Quit] " yn
    echo ""
    case $yn in
        [Yy]* ) echo "Enter number of pods to scale up" 
                read scale_count
        echo "Pods scaled up to $scale_count" && kubectl scale rc keptn-rc --replicas=$scale_count ; break;;
        [Nn]* ) break ;;
        [Qq]* ) exit 0;;
        * ) echo "Please provide a yes or no answer."
    esac
done
echo
while true; do    
    read -p "Do you want to scaldown Pods? [y for Yes  ;  n for No  ;  q  for Quit] " yn
    echo ""
    case $yn in
        [Yy]* ) echo "Enter number of pods to scale down" 
                read scale_count
        echo "Pods scaled down to $scale_count" && kubectl scale rc keptn-rc --replicas=$scale_count ; break;;
        [Nn]* ) break ;;
        [Qq]* ) exit 0;;
        * ) echo "Please provide a yes or no answer."
    esac
done
echo 
while true; do    
    read -p "Do you want to delete this Deployment? [y for Yes  ;  n for No  ;  q  for Quit] " yn
    echo ""
    case $yn in
        [Yy]* ) kubectl delete -f keptn-rc.yaml ; break;;
        [Nn]* ) break ;;
        [Qq]* ) exit 0;;
        * ) echo "Please provide a yes or no answer."
    esac
done
