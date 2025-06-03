using UnityEngine;
using UnityEngine.InputSystem;

[RequireComponent(typeof(CharacterController))]
public class CameraMovement : MonoBehaviour
{
    [Header("Movement")]
    [SerializeField] private float _moveSpeed = 5f;

    [Header("Mouse Look")]
    [SerializeField] private Transform _cameraPivot;
    [SerializeField] private float _mouseSensitivity = 1f;
    [SerializeField] private float _pitchClamp = 80f;

    [SerializeField] private CharacterController _controller;

    private Vector2 _moveInput;
    private Vector2 _lookInput;
    private float _verticalInput;

    private float _pitch = 0f;
    private float _yaw = 0f;

    private void Update()
    {
        HandleMovement();
        HandleMouseLook();
    }

    private void HandleMovement()
    {
        Vector3 move = transform.forward * _moveInput.y + transform.right * _moveInput.x + transform.up * _verticalInput;
        _controller.Move(move * _moveSpeed * Time.deltaTime);
    }

    private void HandleMouseLook()
    {
        _yaw += _lookInput.x * _mouseSensitivity;
        _pitch -= _lookInput.y * _mouseSensitivity;
        _pitch = Mathf.Clamp(_pitch, -_pitchClamp, _pitchClamp);

        transform.rotation = Quaternion.Euler(_pitch, _yaw, 0f);
    }

    public void OnMove(InputAction.CallbackContext context)
    {
        _moveInput = context.ReadValue<Vector2>();
    }

    public void OnUpDown(InputAction.CallbackContext context)
    {
        _verticalInput = context.ReadValue<float>();
    }

    public void OnLook(InputAction.CallbackContext context)
    {
        _lookInput = context.ReadValue<Vector2>();
    }
}
