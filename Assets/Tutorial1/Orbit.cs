using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Orbit : MonoBehaviour
{
    [SerializeField] private float distance;

    [SerializeField] private Transform host;

    [SerializeField] private float speed;

    private float currentRotation;

    // Update is called once per frame
    void Update()
    {
        currentRotation += speed;

        if (currentRotation > 360) currentRotation -= 360;

        transform.eulerAngles = new Vector3(0, 0, currentRotation);

        float rads = Mathf.Deg2Rad * currentRotation;
        transform.position = host.position + new Vector3(Mathf.Cos(rads) * distance, Mathf.Sin(rads) * distance);



    }
}
