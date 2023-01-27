using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MaterialExchanger : MonoBehaviour
{
    [SerializeField] private Material[] mats;
    [SerializeField] private float duration;
    private float _curTime; 
    private MeshRenderer _mr;
    private int _idx;
    private void Awake()
    {
        _mr = GetComponent<MeshRenderer>();
        _mr.material = mats[_idx];
    }

    private void Update()
    {
        _curTime += Time.deltaTime;
        if (_curTime > duration)
        {
            _mr.material = mats[++_idx % mats.Length];
            _curTime = 0;
        }
    }
}
