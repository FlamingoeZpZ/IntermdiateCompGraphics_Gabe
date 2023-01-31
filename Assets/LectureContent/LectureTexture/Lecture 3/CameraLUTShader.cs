using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraLUTShader : MonoBehaviour
{
    //public Shader awesomeShader = null;
    [SerializeField] private Material mRenderMaterial;
    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, mRenderMaterial);
    }
}
