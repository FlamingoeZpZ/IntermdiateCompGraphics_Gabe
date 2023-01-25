using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class CameraMovement : MonoBehaviour
{

    private Controls controls;
    // Start is called before the first frame update

    private Vector2 CamMovement; 
    private Vector2 camTilt;
    [SerializeField] private float speed;
    
    void Awake()
    {
        controls = new Controls();
        
        controls.Enable();

        controls.Camera.WASD.performed += ctx => CamMovement = ctx.ReadValue<Vector2>();
        controls.Camera.Arrows.performed += ctx => camTilt = ctx.ReadValue<Vector2>();
        controls.Camera.Speed.performed += ctx => speed += ctx.ReadValue<float>();
        controls.Camera.ClickObject.started += _ => CastRay();

    }

    private void CastRay()
    {
        
        Vector3 worldPosition =GetComponent<Camera>().ScreenToWorldPoint(Mouse.current.position.ReadValue());
        Vector3 dir = (worldPosition - transform.position).normalized;
        print("Casted" + worldPosition + "/" + dir + " --> " + transform.position + ",  " + Mouse.current.position.ReadValue());
        Debug.DrawRay(transform.position, dir * 1000, Color.cyan, 10);
        if (Physics.Raycast(transform.position, dir, out RaycastHit obj, 1000))
        {
            print("Hit");
            transform.position = obj.point + dir * 10;
        }
    }

    // Update is called once per frame
    void Update()
    {
        transform.position += (Vector3)(Time.deltaTime * speed * CamMovement);
        transform.Rotate(camTilt.y, camTilt.x, 0);
    }
}
