using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class DecalToggler : MonoBehaviour
{
    private readonly int id = Shader.PropertyToID("_ShowDecal");
    private Material mat;
    int v = 0;

    // Start is called before the first frame update
    private void Start()
    {
        mat = GetComponent<Renderer>().sharedMaterial;
    }

    // Update is called once per frame
    void Update()
    {
        if (Mouse.current.press.wasPressedThisFrame)
        {
            print("Setting");
            v = v == 0 ? 1 : 0;
            mat.SetFloat(id, v);
        }
    }
}
