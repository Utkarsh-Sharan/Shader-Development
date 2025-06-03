using UnityEngine;

public class XAxisInterpolator : MonoBehaviour
{
    [SerializeField] private float _speed = 1f;
    private float _minX = -6.5f;
    private float _maxX = -8.3f;

    void Update()
    {
        float newX = Mathf.Lerp(_minX, _maxX, Mathf.PingPong(Time.time * _speed, 1));
        transform.position = new Vector3(newX, transform.position.y, transform.position.z);
    }
}
