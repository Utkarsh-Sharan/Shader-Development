using UnityEngine;

public class YAxisInterpolator : MonoBehaviour
{
    [SerializeField] private float speed = 1f;
    private float minY = -0.5f;
    private float maxY = 0f;

    void Update()
    {
        float newY = Mathf.Lerp(minY, maxY, Mathf.PingPong(Time.time * speed, 1));
        transform.position = new Vector3(transform.position.x, newY, transform.position.z);
    }
}
